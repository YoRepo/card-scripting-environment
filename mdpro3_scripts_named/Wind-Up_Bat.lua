--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 发条蝙蝠  (ID: 42328171)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level 1
-- ATK 300 | DEF 350
-- Setcode: 88
--
-- Effect Text:
-- 自己的主要阶段时才能发动。把自己场上表侧攻击表示存在的这张卡变更为表侧守备表示，选择自己墓地存在的1只名字带有「发条」的怪兽加入手卡。这个效果只在这张卡在场上表侧表示存在能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ゼンマイバット
function c42328171.initial_effect(c)
	--salvage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42328171,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c42328171.thcon)
	e1:SetTarget(c42328171.thtg)
	e1:SetOperation(c42328171.thop)
	c:RegisterEffect(e1)
end
function c42328171.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c42328171.filter(c)
	return c:IsSetCard(0x58) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c42328171.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c42328171.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c42328171.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c42328171.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c42328171.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsPosition(POS_FACEUP_ATTACK) and c:IsControler(tp) and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
