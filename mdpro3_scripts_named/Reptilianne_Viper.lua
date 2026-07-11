--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Reptilianne Viper  (ID: 42303365)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Reptile
-- Level: 2
-- ATK 0 | DEF 0
-- Setcode: 0x3c
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned, you can select and take control of 1 face-up monster with 0 ATK
-- your opponent controls.
--[[ __CARD_HEADER_END__ ]]

--レプティレス・バイパー
function c42303365.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42303365,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetTarget(c42303365.ctltg)
	e1:SetOperation(c42303365.ctlop)
	c:RegisterEffect(e1)
end
function c42303365.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged() and c:IsAttack(0)
end
function c42303365.ctltg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c42303365.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c42303365.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c42303365.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c42303365.ctlop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsAttack(0) then
		Duel.GetControl(tc,tp)
	end
end
