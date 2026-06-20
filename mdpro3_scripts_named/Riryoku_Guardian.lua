--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 守护神的原力  (ID: 96661780)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 82
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己基本分比对方少的场合，以原本卡名包含「门之守护神」的自己场上1只怪兽为对象才能发动。对方基本分变成一半。那之后，作为对象的怪兽的攻击力上升对方基本分数值。
-- ②：把墓地的这张卡除外才能发动。自己的卡组·除外状态的「雷魔神-桑迦」「风魔神-修迦」「水魔神-斯迦」的其中1只加入手卡。
--[[ __CARD_HEADER_END__ ]]

--フォース・オブ・ガーディアン
function c96661780.initial_effect(c)
	aux.AddCodeList(c,25955164,62340868,98434877)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(96661780,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,96661780)
	e1:SetCondition(c96661780.condition)
	e1:SetTarget(c96661780.target)
	e1:SetOperation(c96661780.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(96661780,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,96661781)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c96661780.thtg)
	e2:SetOperation(c96661780.thop)
	c:RegisterEffect(e2)
end
function c96661780.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<Duel.GetLP(1-tp)
end
function c96661780.filter(c)
	return c:IsOriginalSetCard(0x1052) and c:IsFaceup()
end
function c96661780.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c96661780.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c96661780.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c96661780.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c96661780.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(1-tp,math.ceil(Duel.GetLP(1-tp)/2))
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.BreakEffect()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(Duel.GetLP(1-tp))
		tc:RegisterEffect(e1)
	end
end
function c96661780.thfilter(c)
	return c:IsFaceupEx() and c:IsCode(25955164,62340868,98434877) and c:IsAbleToHand()
end
function c96661780.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c96661780.thfilter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_REMOVED)
end
function c96661780.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c96661780.thfilter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
