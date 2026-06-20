--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 妖精传姬-罗奇卡  (ID: 65953423)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1850 | DEF 1000
-- Setcode: 475
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡召唤时才能发动。对方回复500基本分。那之后，对方从把这个效果发动的玩家的卡组上面把3张卡确认，从那之中选1张。自己把对方选的卡加入手卡。剩余回到卡组。
-- ②：这张卡进行战斗的伤害计算前才能发动。这张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--妖精伝姫－ラチカ
function c65953423.initial_effect(c)
	--confirm
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65953423,0))
	e1:SetCategory(CATEGORY_RECOVER+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,65953423)
	e1:SetTarget(c65953423.thtg)
	e1:SetOperation(c65953423.thop)
	c:RegisterEffect(e1)
	--send to gy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(65953423,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_CONFIRM)
	e2:SetCondition(c65953423.batlcon)
	e2:SetTarget(c65953423.batltg)
	e2:SetOperation(c65953423.batlop)
	c:RegisterEffect(e2)
end
function c65953423.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetDecktopGroup(tp,3)
		return #g>=3 and g:IsExists(Card.IsAbleToHand,1,nil)
	end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,1-tp,500)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function c65953423.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Recover(1-tp,500,REASON_EFFECT)~=0 and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=3 then
		Duel.BreakEffect()
		local g=Duel.GetDecktopGroup(tp,3)
		Duel.ConfirmCards(1-tp,g)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
		local sc=g:Select(1-tp,1,1,nil):GetFirst()
		if sc:IsAbleToHand() then
			Duel.SendtoHand(sc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sc)
			Duel.ShuffleHand(tp)
		else
			Duel.SendtoGrave(sc,REASON_RULE)
		end
		Duel.ShuffleDeck(tp)
	end
end
function c65953423.batlcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc and bc:IsRelateToBattle()
end
function c65953423.batltg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGrave() end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,c,1,tp,0)
end
function c65953423.batlop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoGrave(c,REASON_EFFECT)
	end
end
