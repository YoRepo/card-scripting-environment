--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 流星日珥  (ID: 56856951)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方基本分比3000高的场合，把2张手卡送去墓地才能发动。给与对方基本分2000分伤害。这张卡在墓地存在的场合，可以作为自己的抽卡阶段时进行通常抽卡的代替，把这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--メテオ・プロミネンス
function c56856951.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c56856951.damcon)
	e1:SetCost(c56856951.damcost)
	e1:SetTarget(c56856951.damtg)
	e1:SetOperation(c56856951.damop)
	c:RegisterEffect(e1)
	--salvage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(56856951,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PREDRAW)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c56856951.thcon)
	e2:SetTarget(c56856951.thtg)
	e2:SetOperation(c56856951.thop)
	c:RegisterEffect(e2)
end
function c56856951.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(1-tp)>3000
end
function c56856951.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,2,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsAbleToGraveAsCost,2,2,REASON_COST)
end
function c56856951.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(2000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,2000)
end
function c56856951.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c56856951.thcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c56856951.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.IsPlayerCanNormalDraw(tp) and e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c56856951.thop(e,tp,eg,ep,ev,re,r,rp)
	if not aux.IsPlayerCanNormalDraw(tp) then return end
	aux.GiveUpNormalDraw(e,tp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
	end
end
