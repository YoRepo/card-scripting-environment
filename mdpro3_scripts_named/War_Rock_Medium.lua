--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 战吼灵媒  (ID: 81613061)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 351
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要特殊召唤的怪兽在对方场上存在并在自己场上有7星以上的「战吼」怪兽存在，双方的主要阶段1内，双方不能把场上的怪兽的效果发动。
-- ②：自己主要阶段才能发动。从卡组选「战吼灵媒」以外的1张「战吼」魔法·陷阱卡在自己场上盖放。这个效果的发动后，直到回合结束时自己不是战士族怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ウォークライ・ミーディアム
function c81613061.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--act limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetCondition(c81613061.actcon)
	e2:SetValue(c81613061.aclimit)
	c:RegisterEffect(e2)
	--set
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(81613061,0))
	e3:SetCategory(CATEGORY_SSET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,81613061)
	e3:SetTarget(c81613061.settg)
	e3:SetOperation(c81613061.setop)
	c:RegisterEffect(e3)
end
function c81613061.actfilter(c)
	return c:IsSetCard(0x15f) and c:IsLevelAbove(7) and c:IsFaceup()
end
function c81613061.actcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetCurrentPhase()==PHASE_MAIN1
		and Duel.IsExistingMatchingCard(Card.IsSummonType,tp,0,LOCATION_MZONE,1,nil,SUMMON_TYPE_SPECIAL)
		and Duel.IsExistingMatchingCard(c81613061.actfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c81613061.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsLocation(LOCATION_MZONE)
end
function c81613061.setfilter(c)
	return c:IsSetCard(0x15f) and c:IsType(TYPE_SPELL+TYPE_TRAP) and not c:IsCode(81613061) and c:IsSSetable()
end
function c81613061.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81613061.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c81613061.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c81613061.setfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c81613061.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c81613061.splimit(e,c)
	return not c:IsRace(RACE_WARRIOR)
end
