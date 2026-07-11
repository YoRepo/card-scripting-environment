--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Rescue Warrior  (ID: 70630741)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 1600 | DEF 1700
-- Setcode: 0x66
-- Scope: OCG / TCG
--
-- Effect Text:
-- You take no Battle Damage from battles involving this card.
-- If this card is destroyed by battle, select 1 face-up monster your opponent controls that you own,
-- and take control of it.
--[[ __CARD_HEADER_END__ ]]

--レスキュー・ウォリアー
function c70630741.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--control
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(70630741,0))
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetTarget(c70630741.target)
	e2:SetOperation(c70630741.operation)
	c:RegisterEffect(e2)
end
function c70630741.filter(c,tp)
	return c:IsFaceup() and c:GetOwner()==tp and c:IsControlerCanBeChanged()
end
function c70630741.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c70630741.filter(chkc,tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c70630741.filter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c70630741.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp)
	end
end
