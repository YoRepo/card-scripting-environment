--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 幻兽 雷霆飞马  (ID: 34961968)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Level 4
-- ATK 700 | DEF 2000
-- Setcode: 27
--
-- Effect Text:
-- 对方怪兽的攻击宣言时，把墓地的这张卡从游戏中除外，选择自己场上1只名字带有「幻兽」的怪兽才能发动。这个回合，选择的自己怪兽不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--幻獣サンダーペガス
function c34961968.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34961968,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c34961968.condition)
	e1:SetCost(c34961968.cost)
	e1:SetTarget(c34961968.target)
	e1:SetOperation(c34961968.operation)
	c:RegisterEffect(e1)
end
function c34961968.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():IsControler(1-tp)
end
function c34961968.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c34961968.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1b)
end
function c34961968.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c34961968.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c34961968.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(34961968,1))
	Duel.SelectTarget(tp,c34961968.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c34961968.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
