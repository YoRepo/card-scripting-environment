--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 黄金乡的盗墓者  (ID: 93191801)
-- Type: Trap / Equip
-- Attribute: LIGHT
-- Race: Zombie
-- Level 5
-- ATK 1800 | DEF 1500
-- Setcode: 323
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：这张卡发动后变成通常怪兽（不死族·光·5星·攻1800/守1500）在怪兽区域特殊召唤（也当作陷阱卡使用）。自己场上有「黄金卿 黄金国巫妖」存在的场合，可以再从自己或对方的墓地把1张卡除外。
-- ②：自己·对方的结束阶段，把墓地的这张卡除外才能发动。从卡组把1张「黄金国永生药」魔法·陷阱卡在自己场上盖放。
--[[ __CARD_HEADER_END__ ]]

--黄金郷のワッケーロ
function c93191801.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(93191801,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,93191801)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c93191801.target)
	e1:SetOperation(c93191801.activate)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(93191801,1))
	e2:SetCategory(CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c93191801.setcon)
	e2:SetCountLimit(1,93191801)
	e2:SetHintTiming(TIMING_END_PHASE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c93191801.settg)
	e2:SetOperation(c93191801.setop)
	c:RegisterEffect(e2)
end
function c93191801.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,93191801,0,TYPES_NORMAL_TRAP_MONSTER,1800,1500,5,RACE_ZOMBIE,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,0,PLAYER_ALL,LOCATION_GRAVE)
end
function c93191801.filter(c)
	return c:IsFaceup() and c:IsCode(95440946)
end
function c93191801.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,93191801,0,TYPES_NORMAL_TRAP_MONSTER,1800,1500,5,RACE_ZOMBIE,ATTRIBUTE_LIGHT) then return end
	c:AddMonsterAttribute(TYPE_NORMAL+TYPE_TRAP)
	if Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)~=0
		and Duel.IsExistingMatchingCard(c93191801.filter,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(93191801,2)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
		end
	end
end
function c93191801.setfilter(c)
	return c:IsSetCard(0x2142) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c93191801.setcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_END
end
function c93191801.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c93191801.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c93191801.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c93191801.setfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SSet(tp,g)
	end
end
