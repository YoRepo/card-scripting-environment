--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 地雷蜘蛛的饵食  (ID: 33055499)
-- Type: Trap / Equip
-- Attribute: EARTH
-- Race: Insect
-- Level 5
-- ATK 2100 | DEF 100
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡发动后变成通常怪兽（昆虫族·地·5星·攻2100/守100）在正对面的自己的主要怪兽区域特殊召唤（也当作陷阱卡使用）。那之后，可以把和这张卡相同纵列1只对方怪兽破坏。
-- ②：把墓地的这张卡除外才能发动。自己的卡组·除外状态的「雷魔神-桑迦」「风魔神-修迦」「水魔神-斯迦」的其中1只加入手卡。
--[[ __CARD_HEADER_END__ ]]

--地雷蜘蛛の餌食
function c33055499.initial_effect(c)
	aux.AddCodeList(c,25955164,62340868,98434877)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33055499,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,33055499)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c33055499.target)
	e1:SetOperation(c33055499.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33055499,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCountLimit(1,33055500)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c33055499.thtg)
	e2:SetOperation(c33055499.thop)
	c:RegisterEffect(e2)
end
function c33055499.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local seq=e:GetHandler():GetSequence()
	if chk==0 then return e:IsCostChecked()
		and Duel.CheckLocation(tp,LOCATION_MZONE,seq)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,33055499,0,TYPES_NORMAL_TRAP_MONSTER,2100,100,5,RACE_INSECT,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c33055499.filter(c,tp)
	return c:IsControler(1-tp) and c:IsLocation(LOCATION_MZONE)
end
function c33055499.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local seq=c:GetSequence()
	local zone=1<<seq
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,33055499,0,TYPES_NORMAL_TRAP_MONSTER,2100,100,5,RACE_INSECT,ATTRIBUTE_EARTH) then return end
	c:AddMonsterAttribute(TYPE_NORMAL+TYPE_TRAP)
	if Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP,zone)~=0 then
		local g=c:GetColumnGroup():Filter(c33055499.filter,nil,tp)
		if #g>0 and Duel.SelectYesNo(tp,aux.Stringid(33055499,2)) then
			Duel.BreakEffect()
			local tg=g:Clone()
			if #tg>1 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
				tg=g:Select(tp,1,1,nil)
			end
			Duel.HintSelection(tg)
			Duel.Destroy(tg,REASON_EFFECT)
		end
	end
end
function c33055499.thfilter(c)
	return c:IsFaceupEx() and c:IsCode(25955164,62340868,98434877) and c:IsAbleToHand()
end
function c33055499.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33055499.thfilter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_REMOVED)
end
function c33055499.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c33055499.thfilter,tp,LOCATION_DECK+LOCATION_REMOVED,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
