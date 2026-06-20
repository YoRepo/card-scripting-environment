--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 护罩共鸣者  (ID: 89127526)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Fiend
-- Level 1
-- ATK 300 | DEF 800
-- Setcode: 87
--
-- Effect Text:
-- 把这张卡从手卡送去墓地，选择自己场上表侧表示存在的1只调整发动。选择的怪兽在这个回合不会被战斗破坏，选择的怪兽的战斗发生的对自己的战斗伤害变成0。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--バリア・リゾネーター
function c89127526.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89127526,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c89127526.cost)
	e1:SetTarget(c89127526.target)
	e1:SetOperation(c89127526.operation)
	c:RegisterEffect(e1)
end
function c89127526.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c89127526.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_TUNER)
end
function c89127526.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c89127526.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c89127526.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c89127526.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c89127526.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
