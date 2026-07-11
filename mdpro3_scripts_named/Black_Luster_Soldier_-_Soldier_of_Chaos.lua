--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Black Luster Soldier - Soldier of Chaos  (ID: 49202162)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Warrior
-- Link Rating: 3
-- Link Arrows: Top, Bottom-Left, Bottom-Right
-- ATK 3000
-- Setcode: 0x10cf
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 monsters with different names
-- If this card was Link Summoned using a Level 7 or higher monster(s) as material, your opponent
-- cannot target it with card effects, also it cannot be destroyed by your opponent's card effects.
-- When this card destroys an opponent's monster by battle: You can activate 1 of these effects;
-- ● This card gains 1500 ATK.
-- ● This card can make a second attack during the Battle Phase of your next turn.
-- ● Banish 1 card on the field.
--[[ __CARD_HEADER_END__ ]]

--混沌の戦士 カオス・ソルジャー
function c49202162.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,3,3,c49202162.lcheck)
	c:EnableReviveLimit()
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c49202162.regcon)
	e1:SetOperation(c49202162.regop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c49202162.valcheck)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--cannot target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c49202162.tgcon)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c49202162.tgcon)
	e4:SetValue(aux.indoval)
	c:RegisterEffect(e4)
	--effect
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(49202162,0))
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_BATTLE_DESTROYING)
	e5:SetCondition(aux.bdocon)
	e5:SetTarget(c49202162.efftg)
	e5:SetOperation(c49202162.effop)
	c:RegisterEffect(e5)
end
function c49202162.lcheck(g,lc)
	return g:GetClassCount(Card.GetLinkCode)==g:GetCount()
end
function c49202162.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK) and e:GetLabel()==1
end
function c49202162.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(49202162,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(49202162,4))
end
function c49202162.tgcon(e)
	return e:GetHandler():GetFlagEffect(49202162)>0
end
function c49202162.efftg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local b2=c:GetFlagEffect(49202163)==0
	local b3=Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
	if chk==0 then return true end
	local op=0
	if b2 and b3 then
		op=Duel.SelectOption(tp,aux.Stringid(49202162,1),aux.Stringid(49202162,2),aux.Stringid(49202162,3))
	elseif b2 then
		op=Duel.SelectOption(tp,aux.Stringid(49202162,1),aux.Stringid(49202162,2))
	elseif b3 then
		op=Duel.SelectOption(tp,aux.Stringid(49202162,1),aux.Stringid(49202162,3))*2
	else
		op=Duel.SelectOption(tp,aux.Stringid(49202162,1))
	end
	e:SetLabel(op)
end
function c49202162.effop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local op=e:GetLabel()
	if op==0 then
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(1500)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
			c:RegisterEffect(e1)
		end
	elseif op==1 then
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			local tct=0
			if Duel.GetTurnPlayer()==tp then tct=1 end
			local e1=Effect.CreateEffect(c)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EXTRA_ATTACK)
			e1:SetCondition(c49202162.eacon)
			e1:SetLabel(Duel.GetTurnCount())
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN,1+tct)
			c:RegisterEffect(e1)
			c:RegisterFlagEffect(49202163,RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END,0,1+tct)
		end
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		if g:GetCount()>0 then
			Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		end
	end
end
function c49202162.eacon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()~=e:GetLabel()
end
function c49202162.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsLevelAbove,1,nil,7) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end
