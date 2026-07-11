--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Maju Garzett  (ID: 8794435)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 7
-- ATK ? | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- The ATK of this card becomes equal to the combined original ATK of the 2 monsters you Tributed for
-- the Tribute Summon of this card.
--[[ __CARD_HEADER_END__ ]]

--合成魔獣 ガーゼット
function c8794435.initial_effect(c)
	--tribute check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c8794435.valcheck)
	c:RegisterEffect(e1)
	--give atk effect only when summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_COST)
	e2:SetOperation(c8794435.facechk)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c8794435.valcheck(e,c)
	local g=c:GetMaterial()
	local tc=g:GetFirst()
	local atk=0
	while tc do
		local catk=tc:GetTextAttack()
		atk=atk+(catk>=0 and catk or 0)
		tc=g:GetNext()
	end
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
function c8794435.facechk(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(1)
end
