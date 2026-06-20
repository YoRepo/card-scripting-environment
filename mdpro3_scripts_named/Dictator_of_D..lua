--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 龙之支配者-龙之独裁者-  (ID: 66961194)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 1200 | DEF 1100
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：从手卡·卡组把1只「青眼白龙」送去墓地才能发动。这张卡从手卡特殊召唤。
-- ②：从手卡丢弃1只「青眼白龙」或者1张有那个卡名记述的卡，以自己墓地1只「青眼」怪兽为对象才能发动。那只怪兽特殊召唤。
-- ③：只要自己场上有「青眼」怪兽存在，对方选择自身怪兽的攻击对象之际，那个攻击对象由自己选择。
--[[ __CARD_HEADER_END__ ]]

--ロード・オブ・ドラゴン－ドラゴンの独裁者－
function c66961194.initial_effect(c)
	aux.AddCodeList(c,89631139)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66961194,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,66961194)
	e1:SetCost(c66961194.spcost1)
	e1:SetTarget(c66961194.sptg1)
	e1:SetOperation(c66961194.spop1)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66961194,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,66961195)
	e2:SetCost(c66961194.spcost2)
	e2:SetTarget(c66961194.sptg2)
	e2:SetOperation(c66961194.spop2)
	c:RegisterEffect(e2)
	--attack redirect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_PATRICIAN_OF_DARKNESS)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCondition(c66961194.podcond)
	e3:SetTargetRange(0,1)
	c:RegisterEffect(e3)
end
function c66961194.spcostfilter1(c)
	return c:IsCode(89631139) and c:IsAbleToGraveAsCost()
end
function c66961194.spcost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66961194.spcostfilter1,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c66961194.spcostfilter1,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c66961194.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c66961194.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c66961194.spcostfilter2(c)
	return aux.IsCodeOrListed(c,89631139) and c:IsDiscardable()
end
function c66961194.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66961194.spcostfilter2,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	Duel.DiscardHand(tp,c66961194.spcostfilter2,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c66961194.spfilter2(c,e,tp)
	return c:IsSetCard(0xdd) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c66961194.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c66961194.spfilter2(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c66961194.spfilter2,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c66961194.spfilter2,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c66961194.spop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c66961194.podfilter(c)
	return c:IsSetCard(0xdd) and c:IsFaceup()
end
function c66961194.podcond(e)
	local tp=e:GetOwnerPlayer()
	return Duel.IsExistingMatchingCard(c66961194.podfilter,tp,LOCATION_MZONE,0,1,nil)
end
