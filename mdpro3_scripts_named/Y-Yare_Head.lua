--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: Y-机敏龙头  (ID: 6355563)
-- Type: Monster / Effect / Union
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1500 | DEF 1600
--
-- Effect Text:
-- ①：这张卡特殊召唤的场合才能发动。从自己的手卡·墓地把1只机械族·光属性·4星怪兽当作装备魔法卡使用给这张卡装备。这个回合，自己不是光属性怪兽不能从额外卡组特殊召唤。
-- ②：1回合1次，可以把1个以下效果发动。
-- ●以自己场上1只机械族怪兽为对象，把这张卡当作装备魔法卡使用来装备。装备怪兽被战斗·效果破坏的场合，作为代替把这张卡破坏。
-- ●装备状态的这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--Y－ドラゴン・イアヘッド
local s,id,o=GetID()
function s.initial_effect(c)
	aux.EnableUnionAttribute(c,s.filter)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(s.eqtg)
	e1:SetOperation(s.eqop)
	c:RegisterEffect(e1)
end
function s.filter(c)
	return c:IsRace(RACE_MACHINE)
end
function s.eqfilter(c,tc,tp)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsLevel(4)
		and c:CheckUniqueOnField(tp) and not c:IsForbidden()
end
function s.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(s.eqfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,c,tp)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function s.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.eqfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,c,tp)
		local sc=g:GetFirst()
		if sc and Duel.Equip(tp,sc,c) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetLabelObject(c)
			e1:SetValue(s.eqlimit)
			sc:RegisterEffect(e1)
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(s.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function s.splimit(e,c)
	return not c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsLocation(LOCATION_EXTRA)
end
function s.eqlimit(e,c)
	return c==e:GetLabelObject()
end
