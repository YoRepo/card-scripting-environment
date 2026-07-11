--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Mutant Mindmaster  (ID: 11508758)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 6
-- ATK 0 | DEF 2500
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card declares an attack, you can take control of 1 face-up Attack Position monster your
-- opponent controls, and attack with it instead of this monster.
-- It cannot attack your opponent directly.
-- Return it to your opponent at the end of the Battle Phase.
--[[ __CARD_HEADER_END__ ]]

--ミュータント・ハイブレイン
function c11508758.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11508758,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c11508758.ctlcon)
	e1:SetTarget(c11508758.ctltg)
	e1:SetOperation(c11508758.ctlop)
	c:RegisterEffect(e1)
end
function c11508758.ctlcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>=2
end
function c11508758.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsControlerCanBeChanged() and c:IsAttackable()
end
function c11508758.ctltg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc~=Duel.GetAttackTarget() and c11508758.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c11508758.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c11508758.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c11508758.ctlop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsPosition(POS_FACEUP_ATTACK) and tc:IsControler(1-tp) then
		if Duel.GetControl(tc,tp,PHASE_BATTLE,1)~=0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			if tc:IsAttackable() and not tc:IsImmuneToEffect(e) then
				local ats=tc:GetAttackableTarget()
				if #ats==0 then return end
				Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(11508758,1))
				local g=ats:Select(tp,1,1,nil)
				Duel.CalculateDamage(tc,g:GetFirst())
			end
		end
	end
end
