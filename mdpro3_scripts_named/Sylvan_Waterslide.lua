--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 森罗的泷滑  (ID: 49838105)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 144
--
-- Effect Text:
-- 每次对方怪兽直接攻击宣言，可以把这张卡的效果发动。自己卡组最上面的卡翻开。翻开的卡是植物族怪兽的场合，那只怪兽送去墓地。不是的场合，那张卡回到卡组最下面。此外，只要这张卡在场上存在，自己的抽卡阶段时作
-- 为进行通常抽卡的代替，自己卡组最上面的卡翻开。翻开的卡是植物族怪兽的场合，那只怪兽送去墓地。不是的场合，那张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--森羅の滝滑り
function c49838105.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(49838105,0))
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c49838105.condition)
	e2:SetTarget(c49838105.target)
	e2:SetOperation(c49838105.operation)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(49838105,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PREDRAW)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c49838105.cfcon)
	e3:SetTarget(c49838105.cftg)
	e3:SetOperation(c49838105.cfop)
	c:RegisterEffect(e3)
end
function c49838105.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c49838105.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c49838105.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsRace(RACE_PLANT) then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_REVEAL)
	else
		Duel.MoveSequence(tc,SEQ_DECKBOTTOM)
	end
end
function c49838105.cfcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c49838105.cftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.IsPlayerCanNormalDraw(tp) end
	aux.GiveUpNormalDraw(e,tp)
end
function c49838105.cfop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	Duel.DisableShuffleCheck()
	if tc:IsRace(RACE_PLANT) then
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_REVEAL)
	else
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	end
end
