--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 打破命运  (ID: 4008212)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：以自己场上1只「龙骑士 D-终」或者8星以上的「命运英雄」怪兽为对象才能发动。那只怪兽破坏，下次的对方主要阶段1跳过。
-- ②：把墓地的这张卡除外才能发动。把「打破命运」以外的有「龙骑士 D-终」的卡名或者「命运英雄」怪兽的卡名记述的1张魔法·陷阱卡从卡组加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ブレイク・ザ・デステニー
function c4008212.initial_effect(c)
	aux.AddCodeList(c,76263644)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(4008212,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMING_STANDBY_PHASE)
	e1:SetCountLimit(1,4008212)
	e1:SetTarget(c4008212.destg)
	e1:SetOperation(c4008212.desop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(4008212,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCountLimit(1,4008212)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c4008212.thtg)
	e2:SetOperation(c4008212.thop)
	c:RegisterEffect(e2)
end
function c4008212.desfilter(c)
	return c:IsFaceup() and (c:IsCode(76263644) or c:IsSetCard(0xc008) and c:IsLevelAbove(8))
end
function c4008212.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c4008212.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c4008212.desfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c4008212.desfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c4008212.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SKIP_M1)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(0,1)
		if Duel.GetTurnPlayer()==1-tp and Duel.GetCurrentPhase()>=PHASE_MAIN1 then
			e1:SetLabel(Duel.GetTurnCount())
			e1:SetCondition(c4008212.turncon)
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
		else
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1)
		end
		Duel.RegisterEffect(e1,tp)
	end
end
function c4008212.turncon(e)
	return Duel.GetTurnCount()~=e:GetLabel()
end
function c4008212.thfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand() and not c:IsCode(4008212)
		and (aux.IsCodeListed(c,76263644) or aux.IsSetNameMonsterListed(c,0xc008))
end
function c4008212.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c4008212.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c4008212.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c4008212.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
