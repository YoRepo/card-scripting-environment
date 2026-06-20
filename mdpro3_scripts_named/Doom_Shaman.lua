--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 魔族召唤师  (ID: 94944637)
-- Type: Monster / Effect / Gemini
-- Attribute: DARK
-- Race: Spellcaster
-- Level 6
-- ATK 2400 | DEF 2000
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。场上表侧表示存在的这张卡可以作当通常召唤使用的再度召唤，这张卡当作效果怪兽使用并得到以下效果。
-- ●把手卡或者墓地存在的1只恶魔族怪兽特殊召唤。这个效果1回合只能使用1次。这张卡从场上离开时，这个效果特殊召唤的恶魔族怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--魔族召喚師
function c94944637.initial_effect(c)
	aux.EnableDualAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(94944637,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.IsDualState)
	e1:SetTarget(c94944637.target)
	e1:SetOperation(c94944637.operation)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c94944637.desop)
	c:RegisterEffect(e2)
end
function c94944637.filter(c,e,tp)
	return c:IsRace(RACE_FIEND) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c94944637.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c94944637.filter,tp,LOCATION_GRAVE+LOCATION_HAND,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c94944637.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c94944637.filter),tp,LOCATION_GRAVE+LOCATION_HAND,LOCATION_GRAVE,1,1,nil,e,tp)
	local c=e:GetHandler()
	local tc=g:GetFirst()
	if tc then
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)==0 then return end
		if c:IsFaceup() and c:IsRelateToEffect(e) then c:SetCardTarget(tc) end
	end
end
function c94944637.desfilter(c,rc)
	return rc:GetCardTarget():IsContains(c) and c:IsRace(RACE_FIEND)
end
function c94944637.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetCardTargetCount()>0 then
		local dg=Duel.GetMatchingGroup(c94944637.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
