--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 防火龙  (ID: 5043010)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Cyberse
-- ATK 2500 | LINK
-- Setcode: 399
--
-- Effect Text:
-- 怪兽2只以上
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：只在这张卡在场上表侧表示存在才有1次，自己·对方回合，以最多有这张卡所互相连接区的怪兽数量的自己·对方的场上·墓地的怪兽为对象才能发动。那些怪兽回到手卡。
-- ②：这张卡所连接区的怪兽被战斗破坏的场合或者被送去墓地的场合才能发动。从手卡把1只电子界族怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ファイアウォール・ドラゴン
function c5043010.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2)
	c:EnableReviveLimit()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5043010,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,5043010)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c5043010.thtg)
	e1:SetOperation(c5043010.thop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c5043010.regcon)
	e2:SetOperation(c5043010.regop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c5043010.regcon2)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(5043010,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e4:SetCode(EVENT_CUSTOM+5043010)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,5043011)
	e4:SetTarget(c5043010.sptg)
	e4:SetOperation(c5043010.spop)
	c:RegisterEffect(e4)
end
function c5043010.thfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c5043010.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local ct=c:GetMutualLinkedGroupCount()
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and c5043010.thfilter(chkc) end
	if chk==0 then return ct>0 and Duel.IsExistingTarget(c5043010.thfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c5043010.thfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
	c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(5043010,2))
end
function c5043010.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
function c5043010.cfilter(c,tp,zone)
	local seq=c:GetPreviousSequence()
	if c:IsPreviousControler(1-tp) then seq=seq+16 end
	return c:IsPreviousLocation(LOCATION_MZONE) and bit.extract(zone,seq)~=0
end
function c5043010.regcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c5043010.cfilter,1,nil,tp,e:GetHandler():GetLinkedZone())
end
function c5043010.cfilter2(c,tp,zone)
	return not c:IsReason(REASON_BATTLE) and c5043010.cfilter(c,tp,zone)
end
function c5043010.regcon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c5043010.cfilter2,1,nil,tp,e:GetHandler():GetLinkedZone())
end
function c5043010.regop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseSingleEvent(e:GetHandler(),EVENT_CUSTOM+5043010,e,0,tp,0,0)
end
function c5043010.spfilter(c,e,tp)
	return c:IsRace(RACE_CYBERSE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c5043010.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c5043010.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c5043010.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c5043010.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
