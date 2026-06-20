--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 集群拥塞器  (ID: 94703021)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Cyberse
-- Level 7
-- ATK 1000 | DEF 2200
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己场上没有连接怪兽存在，这张卡召唤·特殊召唤成功的场合才能发动。在自己场上把1只「拥塞器衍生物」（电子界族·暗·1星·攻/守0）特殊召唤。
-- ②：自己的连接怪兽被攻击的战斗步骤1次，把那只连接怪兽和墓地的这张卡除外才能发动。把最多有对方场上的连接怪兽数量的「拥塞器衍生物」在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--クラスター・コンジェスター
function c94703021.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,94703021)
	e1:SetCondition(c94703021.tkcon1)
	e1:SetTarget(c94703021.tktg1)
	e1:SetOperation(c94703021.tkop1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--tokens
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetHintTiming(0,TIMING_BATTLE_PHASE)
	e3:SetCondition(c94703021.tkcon2)
	e3:SetCost(c94703021.tkcost2)
	e3:SetTarget(c94703021.tktg2)
	e3:SetOperation(c94703021.tkop2)
	c:RegisterEffect(e3)
end
function c94703021.tkcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_MZONE,0,nil,TYPE_LINK)==0
end
function c94703021.tktg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,94703022,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_CYBERSE,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
end
function c94703021.tkop1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,94703022,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_CYBERSE,ATTRIBUTE_DARK) then
		local tk=Duel.CreateToken(tp,94703022)
		Duel.SpecialSummon(tk,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c94703021.tkcon2(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,0,nil,TYPE_LINK)
	return at and g:IsContains(at)
end
function c94703021.tkcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.bfgcost(e,tp,eg,ep,ev,re,r,rp,0)
		and Duel.GetAttackTarget() and Duel.GetAttackTarget():IsAbleToRemoveAsCost() and Duel.GetMZoneCount(tp,Duel.GetAttackTarget())>0 end
	local g=Group.FromCards(e:GetHandler(),Duel.GetAttackTarget())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c94703021.tktg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsType,tp,0,LOCATION_MZONE,1,nil,TYPE_LINK)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,94703022,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_CYBERSE,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
end
function c94703021.tkop2(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,94703022,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_CYBERSE,ATTRIBUTE_DARK) then return end
	local ct=math.min(Duel.GetMatchingGroupCount(Card.IsType,tp,0,LOCATION_MZONE,nil,TYPE_LINK),(Duel.GetLocationCount(tp,LOCATION_MZONE)))
	if ct<1 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ct=1 end
	repeat
		local token=Duel.CreateToken(tp,94703022)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		ct=ct-1
	until ct<=0 or not Duel.SelectYesNo(tp,aux.Stringid(94703021,0))
	Duel.SpecialSummonComplete()
end
