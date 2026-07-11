--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: The Tripper Mercury  (ID: 3912064)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 8
-- ATK 2000 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Tribute Summoned: You can change all monsters on the field to face-up Attack
-- Position.
-- You can Tribute 3 monsters to Tribute Summon (but not Set) this card.
-- If Summoned this way, while this card is on the field all monsters your opponent controls lose ATK
-- equal to their original ATK.
-- This card can make a second attack during each Battle Phase.
--[[ __CARD_HEADER_END__ ]]

--The tripping MERCURY
function c3912064.initial_effect(c)
	--change position
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c3912064.poscon)
	e1:SetTarget(c3912064.postg)
	e1:SetOperation(c3912064.posop)
	c:RegisterEffect(e1)
	--summon with 3 tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3912064,0))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetCondition(c3912064.ttcon)
	e2:SetOperation(c3912064.ttop)
	e2:SetValue(SUMMON_TYPE_ADVANCE+SUMMON_VALUE_SELF)
	c:RegisterEffect(e2)
	--atk down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(c3912064.atkcon)
	e3:SetValue(c3912064.atkval)
	c:RegisterEffect(e3)
	--extra attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EXTRA_ATTACK)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c3912064.posfilter(c)
	return c:IsDefensePos() or c:IsFacedown()
end
function c3912064.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c3912064.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c3912064.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c3912064.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c3912064.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()==0 then return end
	Duel.ChangePosition(g,POS_FACEUP_ATTACK)
end
function c3912064.ttcon(e,c,minc)
	if c==nil then return true end
	return minc<=3 and Duel.CheckTribute(c,3)
end
function c3912064.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c3912064.atkcon(e)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE+SUMMON_VALUE_SELF
end
function c3912064.atkval(e,c)
	local rec=c:GetBaseAttack()
	if rec<0 then rec=0 end
	return rec*-1
end
