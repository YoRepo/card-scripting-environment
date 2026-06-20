--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 幻影骑士团 沾尘袍  (ID: 90432163)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 3
-- ATK 800 | DEF 1000
-- Setcode: 4315
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡在场上攻击表示存在的场合，以场上1只暗属性怪兽为对象才能发动。这张卡变成守备表示，作为对象的怪兽的攻击力·守备力直到对方回合结束时上升800。
-- ②：把墓地的这张卡除外才能发动。从卡组把「幻影骑士团 沾尘袍」以外的1张「幻影骑士团」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--幻影騎士団ダスティローブ
function c90432163.initial_effect(c)
	--atk/def up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90432163,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,90432163)
	e1:SetCondition(c90432163.condition)
	e1:SetTarget(c90432163.target)
	e1:SetOperation(c90432163.operation)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90432163,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,90432164)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c90432163.thtg)
	e2:SetOperation(c90432163.thop)
	c:RegisterEffect(e2)
end
function c90432163.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c90432163.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK)
end
function c90432163.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c90432163.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90432163.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c90432163.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c90432163.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE)==0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(800)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
	end
end
function c90432163.thfilter(c)
	return c:IsSetCard(0x10db) and not c:IsCode(90432163) and c:IsAbleToHand()
end
function c90432163.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90432163.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c90432163.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c90432163.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
