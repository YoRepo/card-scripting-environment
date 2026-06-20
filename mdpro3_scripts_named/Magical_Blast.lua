--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 魔法爆破  (ID: 91819979)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：给与对方为自己场上的魔法师族怪兽数量×200伤害。
-- ②：这张卡在墓地存在的场合，自己抽卡阶段的抽卡前才能发动。作为这个回合进行通常抽卡的代替，这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--マジックブラスト
function c91819979.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c91819979.damtg)
	e1:SetOperation(c91819979.damop)
	c:RegisterEffect(e1)
	--salvage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(91819979,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PREDRAW)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c91819979.thcon)
	e2:SetTarget(c91819979.thtg)
	e2:SetOperation(c91819979.thop)
	c:RegisterEffect(e2)
end
function c91819979.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end
function c91819979.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c91819979.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	local ct=Duel.GetMatchingGroupCount(c91819979.cfilter,tp,LOCATION_MZONE,0,nil)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct*200)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*200)
end
function c91819979.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetMatchingGroupCount(c91819979.cfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Damage(p,ct*200,REASON_EFFECT)
end
function c91819979.thcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c91819979.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.IsPlayerCanNormalDraw(tp) and e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c91819979.thop(e,tp,eg,ep,ev,re,r,rp)
	if not aux.IsPlayerCanNormalDraw(tp) then return end
	aux.GiveUpNormalDraw(e,tp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
	end
end
