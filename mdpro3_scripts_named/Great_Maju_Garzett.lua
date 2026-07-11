--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Great Maju Garzett  (ID: 47942531)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 6
-- ATK 0 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- The ATK of this card becomes twice the original ATK of 1 monster that you Tributed for the Tribute
-- Summon of this card.
--[[ __CARD_HEADER_END__ ]]

--偉大魔獣 ガーゼット
function c47942531.initial_effect(c)
	--tribute check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c47942531.valcheck)
	c:RegisterEffect(e1)
	--give atk effect only when summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_COST)
	e2:SetOperation(c47942531.facechk)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c47942531.valcheck(e,c)
	local tc=c:GetMaterial():GetFirst()
	local atk=0
	if tc then atk=tc:GetTextAttack()*2 end
	if atk<0 then atk=0 end
	if e:GetLabel()==1 then
		e:SetLabel(0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0xff0000)
		c:RegisterEffect(e1)
	end
end
function c47942531.facechk(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(1)
end
