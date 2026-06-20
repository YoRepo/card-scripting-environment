--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 贵华黄金乡之黄金国永生药  (ID: 22669793)
-- Type: Trap / Equip
-- Attribute: LIGHT
-- Race: Zombie
-- Level 10
-- ATK 1500 | DEF 2800
-- Setcode: 557973827
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：可以支付800基本分，从以下效果选择1个发动。
-- ●这张卡变成通常怪兽（不死族·光·10星·攻1500/守2800）在怪兽区域特殊召唤（也当作陷阱卡使用）。自己场上有「黄金卿 黄金国巫妖」存在的场合，可以再让场上1只怪兽回到手卡。
-- ●自己的除外状态的1张「黄金乡」魔法·陷阱卡或「黄金国永生药」魔法·陷阱卡在自己场上盖放。
--[[ __CARD_HEADER_END__ ]]

--貴き黄金郷のエルドリクシル
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,95440946)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--select effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND+CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCountLimit(1,id)
	e2:SetCost(s.cost)
	e2:SetTarget(s.target)
	e2:SetOperation(s.operation)
	c:RegisterEffect(e2)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function s.thfilter(c)
	return c:IsFaceupEx() and c:IsSetCard(0x143,0x2142) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,id,0,TYPES_NORMAL_TRAP_MONSTER,1500,2800,10,RACE_ZOMBIE,ATTRIBUTE_LIGHT)
	local b2=Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_REMOVED,0,1,nil)
	if chk==0 then return b1 or b2 end
	local op=aux.SelectFromOptions(tp,
		{b1,aux.Stringid(id,1)},
		{b2,aux.Stringid(id,2)})
	e:SetLabel(op)
	if op==1 then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	elseif op==2 then
		e:SetCategory(CATEGORY_SSET)
	end
end
function s.filter(c)
	return c:IsFaceup() and c:IsCode(95440946)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local op=e:GetLabel()
	if op==1 then
		c:AddMonsterAttribute(TYPE_NORMAL+TYPE_TRAP)
		if Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)~=0 and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_ONFIELD,0,1,nil)
			and Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(id,3)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
			local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
			Duel.HintSelection(g)
			local tc=g:GetFirst()
			if tc then
				Duel.SendtoHand(tc,nil,REASON_EFFECT)
			end
		end
	elseif op==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_REMOVED,0,1,1,nil)
		if #g>0 then
			Duel.SSet(tp,g)
		end
		e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	end
end
