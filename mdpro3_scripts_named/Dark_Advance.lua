--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 暗黑上级召唤  (ID: 97001138)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「暗黑上级召唤」在1回合只能发动1张。
-- ①：自己·对方的主要阶段以及战斗阶段，以自己墓地1只攻击力2400以上而守备力1000的怪兽为对象才能发动。那只怪兽加入手卡。那之后，可以从手卡把1只攻击力2400以上而守备力1000的怪兽表侧攻击表
-- 示上级召唤。
--[[ __CARD_HEADER_END__ ]]

--ダーク・アドバンス
function c97001138.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,97001138+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c97001138.condition)
	e1:SetTarget(c97001138.target)
	e1:SetOperation(c97001138.activate)
	c:RegisterEffect(e1)
end
function c97001138.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE) or ph==PHASE_MAIN2
end
function c97001138.thfilter(c)
	return c:IsAttackAbove(2400) and c:IsDefense(1000) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c97001138.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c97001138.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c97001138.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c97001138.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c97001138.sumfilter(c)
	return c:IsAttackAbove(2400) and c:IsDefense(1000) and c:IsSummonable(true,nil,1)
end
function c97001138.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
		local g=Duel.GetMatchingGroup(c97001138.sumfilter,tp,LOCATION_HAND,0,nil)
		if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(97001138,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
			local sc=g:Select(tp,1,1,nil):GetFirst()
			Duel.ShuffleHand(tp)
			Duel.Summon(tp,sc,true,nil,1)
		else
			Duel.ShuffleHand(tp)
		end
	end
end
