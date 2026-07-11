--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Chimeratech Megafleet Dragon  (ID: 87116928)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Machine
-- Level: 10
-- ATK 0 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Cyber Dragon" monster + 1+ monsters in the Extra Monster Zone
-- Cannot be used as Fusion Material.
-- Must first be Special Summoned (from your Extra Deck) by sending the above cards from either field
-- to the GY.
-- The original ATK of this card becomes 1200 x the number of materials used for its Special Summon.
--[[ __CARD_HEADER_END__ ]]

--キメラテック・メガフリート・ドラゴン
function c87116928.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1093),c87116928.matfilter,1,127,true)
	aux.AddContactFusionProcedure(c,c87116928.cfilter,LOCATION_MZONE,LOCATION_MZONE,c87116928.sprop(c))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c87116928.splimit)
	c:RegisterEffect(e1)
	--cannot be fusion material
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
c87116928.material_setcode=0x1093
function c87116928.matfilter(c)
	return c:GetSequence()>4
end
function c87116928.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c87116928.cfilter(c,fc)
	return c:IsAbleToGraveAsCost() and (c:IsControler(fc:GetControler()) or c:IsFaceup())
end
function c87116928.sprop(c)
	return	function(g)
				Duel.SendtoGrave(g,REASON_COST)
				--spsummon condition
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_SET_BASE_ATTACK)
				e1:SetReset(RESET_EVENT+0xff0000)
				e1:SetValue(g:GetCount()*1200)
				c:RegisterEffect(e1)
			end
end
