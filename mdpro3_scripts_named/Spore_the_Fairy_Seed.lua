--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 妖精胞 孢子  (ID: 98888032)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Plant
-- Level 1
-- ATK 400 | DEF 800
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡特殊召唤的场合才能发动。这张卡的等级上升最多有自己场上的怪兽数量的数值。
-- ②：这张卡在墓地存在，自己场上有「古代妖精龙」或者兽族·植物族·天使族的光属性怪兽的其中任意种存在的场合才能发动。这张卡特殊召唤。这个效果的发动后，直到回合结束时自己不是同调怪兽不能从额外卡组特殊召唤
-- 。
--[[ __CARD_HEADER_END__ ]]

--妖精胞スポーア
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,25862681)
	--lv up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(s.lvcon)
	e1:SetOperation(s.lvop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.spcon)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
end
function s.lvcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLevelAbove(0)
end
function s.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	if c:IsFaceup() and c:IsRelateToEffect(e) and c:IsType(TYPE_MONSTER) and ct>0 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,2))
		local lv=Duel.AnnounceLevel(tp,1,ct)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		e1:SetValue(lv)
		c:RegisterEffect(e1)
	end
end
function s.cfilter(c)
	return c:IsFaceupEx() and (c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_BEAST+RACE_FAIRY+RACE_PLANT) and c:IsType(TYPE_MONSTER)
		or c:IsCode(25862681))
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and aux.NecroValleyFilter()(c) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(s.limit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function s.limit(e,c)
	return c:IsLocation(LOCATION_EXTRA) and not c:IsType(TYPE_SYNCHRO)
end
