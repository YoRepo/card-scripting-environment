--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Code Talker  (ID: 53413628)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Cyberse
-- Link Rating: 2
-- Link Arrows: Top, Bottom
-- ATK 1300
-- Setcode: 0x101
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Effect Monsters
-- Gains 500 ATK for each monster this card points to.
-- Cannot be destroyed by battle or your opponent's card effects, while this card points to a monster.
--[[ __CARD_HEADER_END__ ]]

--コード・トーカー
function c53413628.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2,2)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c53413628.atkval)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c53413628.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(aux.indoval)
	c:RegisterEffect(e3)
end
function c53413628.atkval(e,c)
	return c:GetLinkedGroupCount()*500
end
function c53413628.indcon(e)
	return e:GetHandler():GetLinkedGroupCount()>0
end
