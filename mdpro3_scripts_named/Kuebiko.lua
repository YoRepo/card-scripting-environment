--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 久延毘古  (ID: 20087414)
-- Type: Trap / Equip
-- Attribute: EARTH
-- Race: Fairy
-- Level 2
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：这张卡发动后变成持有以下效果的效果怪兽（天使族·地·2星·攻/守0）在怪兽区域特殊召唤（也当作陷阱卡使用）。
-- ●自己场上的卡为对象的场上的怪兽的效果由对方发动时才能发动（同一连锁上最多1次）。这张卡在自己的魔法与陷阱区域盖放，那个对方的效果无效。那只怪兽的攻击力是对方场上最高的场合，再让那只怪兽回到手卡。
--[[ __CARD_HEADER_END__ ]]

--久延毘古
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_DISABLE+CATEGORY_TOHAND+CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(s.discon)
	e2:SetTarget(s.distg)
	e2:SetOperation(s.disop)
	c:RegisterEffect(e2)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,id,0,TYPES_EFFECT_TRAP_MONSTER,0,0,2,RACE_FAIRY,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,id,0,TYPES_EFFECT_TRAP_MONSTER,0,0,2,RACE_FAIRY,ATTRIBUTE_EARTH) then return end
	c:AddMonsterAttribute(TYPE_EFFECT+TYPE_TRAP)
	Duel.SpecialSummon(c,SUMMON_VALUE_SELF,tp,tp,true,false,POS_FACEUP)
end
function s.discfilter(c,tp)
	return c:IsControler(tp) and c:IsOnField()
end
function s.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) or not c:GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_SELF then return false end
	if rp~=1-tp or not re:IsActiveType(TYPE_MONSTER) or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local loc,tg=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION,CHAININFO_TARGET_CARDS)
	return loc==LOCATION_MZONE and tg and tg:IsExists(s.discfilter,1,nil,tp) and Duel.IsChainDisablable(ev)
end
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local rc=re:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local tg=g:GetMaxGroup(Card.GetAttack)
	local rchk=tg:IsContains(rc) and rc:IsRelateToEffect(re)
	if chk==0 then return c:IsSSetable() and (not rchk or rc:IsAbleToHand()) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if rchk then
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,eg,1,0,0)
	end
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local tg=g:GetMaxGroup(Card.GetAttack)
	local c=e:GetHandler()
	local rc=re:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SSet(tp,c) and Duel.NegateEffect(ev) and tg:IsContains(rc) and rc:IsRelateToEffect(re) then
		Duel.BreakEffect()
		Duel.SendtoHand(rc,nil,REASON_EFFECT)
	end
end
