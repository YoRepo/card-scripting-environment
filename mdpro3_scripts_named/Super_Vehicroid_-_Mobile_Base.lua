--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 超级交通机人-移动基地  (ID: 17745969)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Machine
-- Level 10
-- ATK 0 | DEF 5000
-- Setcode: 4118
--
-- Effect Text:
-- 「机人」融合怪兽＋「机人」怪兽
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：以对方场上1只表侧表示怪兽为对象才能发动。把持有那只怪兽的攻击力以下的攻击力的1只「机人」怪兽从卡组·额外卡组特殊召唤。
-- ②：自己·对方的结束阶段以这张卡以外的自己的主要怪兽区域1只「机人」怪兽为对象才能发动。那只自己怪兽回到持有者手卡，这张卡的位置向那个怪兽区域移动。
--[[ __CARD_HEADER_END__ ]]

--スーパービークロイド－モビルベース
function c17745969.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c17745969.matfilter,aux.FilterBoolFunction(Card.IsFusionSetCard,0x16),true)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17745969,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,17745969)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c17745969.sptg)
	e1:SetOperation(c17745969.spop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17745969,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c17745969.mvtg)
	e2:SetOperation(c17745969.mvop)
	c:RegisterEffect(e2)
end
function c17745969.matfilter(c)
	return c:IsFusionType(TYPE_FUSION) and c:IsFusionSetCard(0x16)
end
function c17745969.spfilter1(c,e,tp)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c17745969.spfilter2,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil,e,tp,c:GetAttack())
end
function c17745969.spfilter2(c,e,tp,atk)
	return c:IsSetCard(0x16) and c:IsAttackBelow(atk) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and (c:IsLocation(LOCATION_DECK) and Duel.GetMZoneCount(tp)>0
			or c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0)
end
function c17745969.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c17745969.spfilter1(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c17745969.spfilter1,tp,0,LOCATION_MZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c17745969.spfilter1,tp,0,LOCATION_MZONE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_EXTRA)
end
function c17745969.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c17745969.spfilter2,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil,e,tp,tc:GetAttack())
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function c17745969.mvfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x16) and c:IsAbleToHand() and c:GetSequence()<5
end
function c17745969.mvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c17745969.mvfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c17745969.mvfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c17745969.mvfilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c17745969.mvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsControler(tp) and Duel.SendtoHand(tc,nil,REASON_EFFECT)>0
		and tc:IsLocation(LOCATION_HAND) and c:IsFaceup() and c:IsRelateToEffect(e) then
		local seq=tc:GetPreviousSequence()
		Duel.MoveSequence(c,seq)
	end
end
