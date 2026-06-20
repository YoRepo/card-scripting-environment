--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 时间潜行者·腕表调校员  (ID: 64730881)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Psychic
-- Level 4
-- ATK 1200 | DEF 1800
-- Setcode: 294
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：自己对「时间潜行者·腕表调校员」以外的「时间潜行者」怪兽的召唤·特殊召唤成功的场合才能发动。这张卡从手卡特殊召唤。
-- ②：这张卡召唤·特殊召唤成功的场合才能发动。从卡组把「时间潜行者·腕表调校员」以外的1张「时间潜行者」卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--クロノダイバー・アジャスター
function c64730881.initial_effect(c)
	--Special Summon this card
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64730881,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,64730881)
	e1:SetCondition(c64730881.spcon)
	e1:SetTarget(c64730881.sptg)
	e1:SetOperation(c64730881.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--Send 1 Chrono Diver card to the GY
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(64730881,1))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCountLimit(1,64730881)
	e3:SetTarget(c64730881.tgtg)
	e3:SetOperation(c64730881.tgop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function c64730881.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x126) and not c:IsCode(64730881) and c:IsSummonPlayer(tp)
end
function c64730881.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c64730881.cfilter,1,nil,tp)
end
function c64730881.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c64730881.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c64730881.tgfilter(c)
	return c:IsSetCard(0x126) and not c:IsCode(64730881) and c:IsAbleToGrave()
end
function c64730881.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64730881.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c64730881.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c64730881.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
