--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 鹰身女郎 爪牙碎断  (ID: 63261835)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Winged Beast
-- Level 8
-- ATK 2600 | DEF 1400
-- Setcode: 100
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这张卡同调召唤的场合，可以把自己场上1只「鹰身」怪兽当作调整使用。这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡的卡名只要在场上·墓地存在当作「鹰身女郎」使用。
-- ②：魔法·陷阱卡的效果发动时，以对方场上1只怪兽或者自己场上1只「鹰身」怪兽为对象才能发动。那只怪兽回到手卡。
--[[ __CARD_HEADER_END__ ]]

--ハーピィ・レディ・SC
function c63261835.initial_effect(c)
	--synchro summon
	c:EnableReviveLimit()
	aux.AddSynchroMixProcedure(c,c63261835.matfilter1,nil,nil,aux.NonTuner(nil),1,99)
	--change name
	aux.EnableChangeCode(c,76812113,LOCATION_MZONE+LOCATION_GRAVE)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(63261835,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,63261835)
	e2:SetCondition(c63261835.thcon)
	e2:SetTarget(c63261835.thtg)
	e2:SetOperation(c63261835.thop)
	c:RegisterEffect(e2)
end
function c63261835.matfilter1(c,syncard)
	return c:IsTuner(syncard) or c:IsSetCard(0x64)
end
function c63261835.thcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c63261835.thfilter(c,tp)
	return (c:IsControler(1-tp) or (c:IsFaceup() and c:IsSetCard(0x64))) and c:IsAbleToHand()
end
function c63261835.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c63261835.thfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c63261835.thfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c63261835.thfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c63261835.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
