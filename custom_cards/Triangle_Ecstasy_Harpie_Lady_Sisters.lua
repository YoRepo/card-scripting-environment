--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-10-16T00:00:00
-- Card: Triangle Ecstasy Harpie Lady Sisters  (ID: 101403033)
-- Type: Monster / Effect / Fusion
-- Attribute: WIND
-- Race: Winged Beast
-- Level 8
-- ATK 3000 | DEF 2100
-- Setcode: 0x64 (Harpie)
--
-- Materials: 3 "Harpie Lady" monsters
--
-- Effect Text:
-- Must first be Fusion Summoned.
-- ① This card's name becomes "Harpie Lady" while in the field or GY.
-- ② Gains 500 ATK for each "Harpie Lady" in your GY. Your opponent cannot target this card with
-- non-WIND monsters' effects.
-- ③ Once per turn (Quick Effect): You can destroy all Spells and Traps your opponent controls.
--[[ __CARD_HEADER_END__ ]]

--Triangle Ecstasy Harpie Lady Sisters
local s,id,o=GetID()
function s.initial_effect(c)
	--the materials name "Harpie Lady" (EnableChangeCode below registers it too)
	aux.AddCodeList(c,76812113)
	c:EnableReviveLimit()
	--fusion material: 3 "Harpie Lady" monsters
	--(no Fusion Substitutes: FunRep passes sub=false; cf. Gem-Knight Master Diamond, Hecahands Xeno)
	aux.AddFusionProcFunRep(c,s.hlmfilter,3,true)
	--must first be Fusion Summoned (only gated in the Extra Deck, so it can be revived after a proper summon)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(s.splimit)
	c:RegisterEffect(e0)
	--(1) name becomes "Harpie Lady" while on the field or in the GY
	aux.EnableChangeCode(c,76812113,LOCATION_MZONE+LOCATION_GRAVE)
	--(2) gains 500 ATK for each "Harpie Lady" in your GY
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(s.atkval)
	c:RegisterEffect(e1)
	--(2) your opponent cannot target this card with non-WIND monsters' effects
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetValue(s.tgval)
	c:RegisterEffect(e2)
	--(3) once per turn (Quick Effect): destroy all Spells and Traps your opponent controls
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	--same resolution and hint timing as Prank-Kids Rip-Roarin-Roaster (minus its Tribute cost); no Damage Step flag (neither it nor Harpie's Feather Duster sets one)
	e3:SetHintTiming(0,TIMING_END_PHASE)
	e3:SetRange(LOCATION_MZONE)
	--"Once per turn" without the name: per copy (cf. Tornado Dragon)
	e3:SetCountLimit(1)
	e3:SetTarget(s.destg)
	e3:SetOperation(s.desop)
	c:RegisterEffect(e3)
end
--Fusion Material
--"Harpie Lady" monster: a monster with "Harpie Lady" in its name. "Harpie Lady 1/2/3" and "Cyber Harpie Lady" are aliases of
--"Harpie Lady" and the "name becomes "Harpie Lady"" monsters are 76812113 on the field/GY; the rest are listed by code:
--"Harpie Lady Sisters", "Toon Harpie Lady", "Cyber Slash Harpie Lady", the "Harpie Lady - " customs,
--"Harpie Lady - Elegant Egotist" (pre-release 100459003), "Harpie Lady - Alluring Dance" and
--"Triangle Ecstasy Harpie Lady Sisters" (keep this list in sync across the IMPH scripts)
function s.hlmfilter(c)
	return c:IsFusionCode(76812113,12206212,64116319,63261835,99810010,99810020,99810030,100459003,101403008,101403033)
end
--Summoning Condition (cf. Gem-Knight Master Diamond / Greedy Venom Fusion Dragon / the house Harpie Fusions)
function s.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or aux.fuslimit(e,se,sp,st)
end
--(2)
--bare "Harpie Lady" is the card name, not the "Harpie Lady" monster list: aliases and monsters whose name becomes
--"Harpie Lady" in the GY count, "Harpie Lady Sisters"/"Toon Harpie Lady" do not (cf. D.3.S. Frog, Harpie's Pet Dragon)
function s.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,c:GetControler(),LOCATION_GRAVE,0,nil,76812113)*500
end
--opponent's non-WIND monster effects (cf. Sea Stealth II's non-WATER test); "your opponent" is the activating player
--rp, as in Myutant Beast / Drytron Meteonis Draconids
function s.tgval(e,re,rp)
	return aux.tgoval(e,re,rp) and re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsNonAttribute(ATTRIBUTE_WIND)
end
--(3)
--every Spell/Trap the opponent controls, Set cards included (cf. Harpie's Feather Duster)
function s.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.desfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(s.desfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	--re-collected at resolution; does not need this card on the field (cf. Prank-Kids Rip-Roarin-Roaster)
	local g=Duel.GetMatchingGroup(s.desfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
