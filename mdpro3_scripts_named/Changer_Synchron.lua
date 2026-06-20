--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 变更同调士  (ID: 25652655)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Machine
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 4119
--
-- Effect Text:
-- 这张卡被同调怪兽的同调召唤使用送去墓地的场合，选择对方场上存在的1只怪兽把表示形式变更。
--[[ __CARD_HEADER_END__ ]]

--チェンジ・シンクロン
function c25652655.initial_effect(c)
	--position
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25652655,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c25652655.condition)
	e1:SetTarget(c25652655.target)
	e1:SetOperation(c25652655.operation)
	c:RegisterEffect(e1)
end
function c25652655.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
end
function c25652655.filter(c)
	return c:IsCanChangePosition()
end
function c25652655.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c25652655.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c25652655.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c25652655.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
