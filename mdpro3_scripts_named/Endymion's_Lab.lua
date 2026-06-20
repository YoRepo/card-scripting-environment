--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 魔法都市的实验设施  (ID: 65342096)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 298
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：这张卡只要在魔法与陷阱区域存在，卡名当作「魔法都市 恩底弥翁」使用。
-- ②：每次自己或者对方把魔法卡发动，给这张卡放置1个魔力指示物。
-- ③：1回合1次，自己的魔法师族怪兽被战斗破坏的伤害计算后，把自己场上6个魔力指示物取除才能发动。从手卡·卡组把1只7星以上的魔法师族怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--魔法都市の実験施設
function c65342096.initial_effect(c)
	c:EnableCounterPermit(0x1)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,65342096+EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
	--Code Change
	aux.EnableChangeCode(c,39910367)
	--Add Counter
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(aux.chainreg)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EVENT_CHAIN_SOLVED)
	e4:SetRange(LOCATION_SZONE)
	e4:SetOperation(c65342096.counterop)
	c:RegisterEffect(e4)
	--Special Summon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(65342096,0))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_BATTLED)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1)
	e5:SetCondition(c65342096.spcon)
	e5:SetCost(c65342096.spcost)
	e5:SetTarget(c65342096.sptg)
	e5:SetOperation(c65342096.spop)
	c:RegisterEffect(e5)
end
function c65342096.counterop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and e:GetHandler():GetFlagEffect(FLAG_ID_CHAINING)>0 then
		e:GetHandler():AddCounter(0x1,1)
	end
end
function c65342096.spconcheck(c,tp)
	return c and c:IsRace(RACE_SPELLCASTER) and c:IsControler(tp) and c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c65342096.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil
		and (c65342096.spconcheck(Duel.GetAttacker(),tp)
		or c65342096.spconcheck(Duel.GetAttackTarget(),tp))
end
function c65342096.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1,6,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1,6,REASON_COST)
end
function c65342096.spfilter(c,e,tp)
	return c:IsRace(RACE_SPELLCASTER) and c:IsLevelAbove(7) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c65342096.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c65342096.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c65342096.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c65342096.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
