--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 正义盟军 擒敌乌贼  (ID: 45033006)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 6
-- ATK 1800 | DEF 1800
-- Setcode: 1
--
-- Effect Text:
-- 这张卡召唤成功时，直到这个回合的结束阶段时可以得到对方场上里侧守备表示存在的1只怪兽的控制权。
--[[ __CARD_HEADER_END__ ]]

--A・O・J エネミー・キャッチャー
function c45033006.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45033006,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c45033006.target)
	e1:SetOperation(c45033006.operation)
	c:RegisterEffect(e1)
end
function c45033006.filter(c)
	return c:IsFacedown() and c:IsDefensePos() and c:IsControlerCanBeChanged()
end
function c45033006.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c45033006.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c45033006.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c45033006.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c45033006.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFacedown() and tc:IsDefensePos() then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
