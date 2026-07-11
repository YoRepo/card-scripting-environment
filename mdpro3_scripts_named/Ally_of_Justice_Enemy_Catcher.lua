--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Ally of Justice Enemy Catcher  (ID: 45033006)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 6
-- ATK 1800 | DEF 1800
-- Setcode: 0x1
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned: You can target 1 face-down Defense Position monster your opponent
-- controls; take control of that target until the End Phase.
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
