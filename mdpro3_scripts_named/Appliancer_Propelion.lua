--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Appliancer Propelion  (ID: 81769387)
-- Type: Monster / Effect / Link
-- Attribute: WIND
-- Race: Machine
-- Link Rating: 1
-- Link Arrows: Top
-- ATK 1200
-- Setcode: 0x14b
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Appliancer" monster
-- Cannot be used as Link Material the turn it is Link Summoned.
-- This card can attack directly.
-- Once per turn, during damage calculation, if your monster battles an opponent's monster, while this
-- card is co-linked (Quick Effect): You can make that opponent's monster's ATK 0 during that damage
-- calculation only.
-- Once per turn, during damage calculation, if this monster that is not co-linked battles an
-- opponent's monster (Quick Effect): You can make that opponent's monster's ATK 0 during that damage
-- calculation only.
--[[ __CARD_HEADER_END__ ]]

--扇風機塊プロペライオン
function c81769387.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x14b),1,1)
	c:EnableReviveLimit()
	--cannot link material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e1:SetValue(c81769387.lmlimit)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(81769387,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c81769387.atkcon1)
	e3:SetTarget(c81769387.atktg)
	e3:SetOperation(c81769387.atkop)
	c:RegisterEffect(e3)
	--atk
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(81769387,1))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c81769387.atkcon2)
	e4:SetTarget(c81769387.atktg)
	e4:SetOperation(c81769387.atkop)
	c:RegisterEffect(e4)
end
function c81769387.lmlimit(e)
	local c=e:GetHandler()
	return c:IsStatus(STATUS_SPSUMMON_TURN) and c:IsSummonType(SUMMON_TYPE_LINK)
end
function c81769387.atkcon1(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return e:GetHandler():GetMutualLinkedGroupCount()>0 and d and a:GetControler()~=d:GetControler()
end
function c81769387.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetBattleMonster(1-tp)
	if chk==0 then return tc and not tc:IsAttack(0) end
end
function c81769387.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetBattleMonster(1-tp)
	if tc and tc:IsFaceup() and tc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		tc:RegisterEffect(e1)
	end
end
function c81769387.atkcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:GetMutualLinkedGroupCount()==0 and bc and bc:IsControler(1-tp)
end
