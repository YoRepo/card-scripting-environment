--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 暗黑安琪儿  (ID: 28593329)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level 5
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己的天使族怪兽被选择作为攻击对象时，把那只怪兽解放，把这张卡从手卡送去墓地，以自己场上1只表侧表示怪兽为对象才能发动。攻击对象转移为那只自己怪兽，作为对象的怪兽的攻击力直到回合结束时上升解放的天
-- 使族怪兽的原本攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--ダーク・エンジェル
function c28593329.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(28593329,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c28593329.cost)
	e1:SetTarget(c28593329.target)
	e1:SetOperation(c28593329.activate)
	c:RegisterEffect(e1)
end
function c28593329.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local at=Duel.GetAttackTarget()
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost()
		and at and at:IsControler(tp) and at:IsRace(RACE_FAIRY) and at:IsReleasable() end
	e:SetLabel(at:GetBaseAttack())
	Duel.Release(at,REASON_COST)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c28593329.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local at=Duel.GetAttackTarget()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() and chkc~=at end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,at) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,at)
end
function c28593329.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc:IsRelateToEffect(e) then
		Duel.ChangeAttackTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
