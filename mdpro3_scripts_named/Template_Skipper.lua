--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 模板弹涂鱼  (ID: 24521325)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Cyberse
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：这张卡可以从手卡往作为电子界族连接怪兽所连接区的自己场上特殊召唤。
-- ②：自己主要阶段才能发动。从自己的手卡·墓地把1只电子界族怪兽除外。这个回合连接召唤的场合，这张卡可以作为这个效果除外的怪兽的同名卡来成为连接素材。
--[[ __CARD_HEADER_END__ ]]

--テンプレート・スキッパー
local s,id,o=GetID()
function s.initial_effect(c)
	--linkzone special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.spcon)
	e1:SetValue(s.spval)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetTarget(s.rmtg)
	e2:SetOperation(s.rmop)
	c:RegisterEffect(e2)
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_CYBERSE) and c:IsType(TYPE_LINK)
end
function s.checkzone(tp)
	local zone=0
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	for tc in aux.Next(g) do
		zone=zone|tc:GetLinkedZone(tp)
	end
	return zone&0x1f
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local zone=s.checkzone(tp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
end
function s.spval(e,c)
	local tp=c:GetControler()
	local zone=s.checkzone(tp)
	return 0,zone
end
function s.rmfilter(c,tc)
	return c:IsRace(RACE_CYBERSE) and c:IsAbleToRemove()
end
function s.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.rmfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function s.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local cg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.rmfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,aux.ExceptThisCard(e))
	if cg:GetCount()==0 then return end
	local code1,code2=cg:GetFirst():GetOriginalCodeRule()
	if Duel.Remove(cg,POS_FACEUP,REASON_EFFECT)~=0 and cg:IsExists(Card.IsLocation,1,nil,LOCATION_REMOVED)
		and c:IsRelateToEffect(e) and c:IsFaceup() and c:IsType(TYPE_MONSTER) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ADD_LINK_CODE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(code1)
		c:RegisterEffect(e1)
		if code2 then
			local e2=e1:Clone()
			e2:SetValue(code2)
			c:RegisterEffect(e2)
		end
	end
end
