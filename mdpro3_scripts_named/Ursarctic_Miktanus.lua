--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 北极天熊-小黑熊  (ID: 55936191)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Beast
-- Level 7
-- ATK 700 | DEF 1700
-- Setcode: 355
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己·对方的主要阶段，从手卡把这张卡以外的1只7星以上的怪兽解放才能发动。这张卡从手卡特殊召唤。这个效果的发动后，直到回合结束时自己若非持有等级的怪兽则不能特殊召唤。
-- ②：这张卡特殊召唤成功的场合，以「北极天熊-小黑熊」以外的自己墓地1只「北极天熊」怪兽为对象才能发动。那只怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ベアルクティ－ミクタナス
function c55936191.initial_effect(c)
	--spsummon
	local e1=aux.AddUrsarcticSpSummonEffect(c)
	e1:SetDescription(aux.Stringid(55936191,0))
	e1:SetCountLimit(1,55936191)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(55936191,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,55936192)
	e2:SetTarget(c55936191.thtg)
	e2:SetOperation(c55936191.thop)
	c:RegisterEffect(e2)
end
function c55936191.thfilter(c)
	return c:IsSetCard(0x163) and c:IsType(TYPE_MONSTER) and not c:IsCode(55936191) and c:IsAbleToHand()
end
function c55936191.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c55936191.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c55936191.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c55936191.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c55936191.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
