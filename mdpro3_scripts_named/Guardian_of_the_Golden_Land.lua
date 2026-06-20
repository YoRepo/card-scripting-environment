--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 黄金乡的守护者  (ID: 67007102)
-- Type: Trap / Equip
-- Attribute: LIGHT
-- Race: Zombie
-- Level 8
-- ATK 800 | DEF 2500
-- Setcode: 5374275
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：这张卡发动后变成通常怪兽（不死族·光·8星·攻800/守2500）在怪兽区域特殊召唤。这张卡也当作陷阱卡使用。自己场上有「黄金卿
-- 黄金国巫妖」存在的场合，可以再选场上1只表侧表示怪兽把攻击力变成0。
-- ②：自己·对方的结束阶段把墓地的这张卡除外才能发动。从卡组选1张「黄金国永生药」魔法·陷阱卡在自己场上盖放。
--[[ __CARD_HEADER_END__ ]]

--黄金郷のガーディアン
function c67007102.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67007102,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,67007102)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c67007102.target)
	e1:SetOperation(c67007102.activate)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(67007102,1))
	e2:SetCategory(CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c67007102.setcon)
	e2:SetCountLimit(1,67007102)
	e2:SetHintTiming(TIMING_END_PHASE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c67007102.settg)
	e2:SetOperation(c67007102.setop)
	c:RegisterEffect(e2)
end
function c67007102.atkfilter(c)
	return c:IsFaceup() and c:GetAttack()>0
end
function c67007102.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,67007102,0,TYPES_NORMAL_TRAP_MONSTER,800,2500,8,RACE_ZOMBIE,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c67007102.filter(c)
	return c:IsFaceup() and c:IsCode(95440946)
end
function c67007102.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,67007102,0,TYPES_NORMAL_TRAP_MONSTER,800,2500,8,RACE_ZOMBIE,ATTRIBUTE_LIGHT) then return end
	c:AddMonsterAttribute(TYPE_NORMAL+TYPE_TRAP)
	if Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)~=0
		and Duel.IsExistingMatchingCard(c67007102.filter,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingMatchingCard(c67007102.atkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(67007102,2)) then
		Duel.BreakEffect()
		local g=Duel.SelectMatchingCard(tp,c67007102.atkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		Duel.HintSelection(g)
		local tc=g:GetFirst()
		if tc then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetValue(0)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
		end
	end
end
function c67007102.setfilter(c)
	return c:IsSetCard(0x2142) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c67007102.setcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_END
end
function c67007102.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c67007102.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c67007102.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c67007102.setfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SSet(tp,g)
	end
end
