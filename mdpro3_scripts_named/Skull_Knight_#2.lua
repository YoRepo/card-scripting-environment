--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 骷髅骑士  (ID: 15653824)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 1000 | DEF 1200
--
-- Effect Text:
-- 用这张卡做祭品召唤恶魔族怪兽的场合，从卡组特殊召唤1张「骷髅骑士」上场。之后卡组洗切。
--[[ __CARD_HEADER_END__ ]]

--スカル・ナイト
function c15653824.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15653824,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c15653824.spcon)
	e1:SetTarget(c15653824.sptg)
	e1:SetOperation(c15653824.spop)
	c:RegisterEffect(e1)
end
function c15653824.spcon(e,tp,eg,ep,ev,re,r,rp)
	if r~=REASON_SUMMON then return false end
	local rc=e:GetHandler():GetReasonCard()
	return rc:IsFaceup() and rc:IsRace(RACE_FIEND)
end
function c15653824.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c15653824.spfilter(c,e,tp)
	return c:IsCode(15653824) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c15653824.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.GetFirstMatchingCard(c15653824.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
