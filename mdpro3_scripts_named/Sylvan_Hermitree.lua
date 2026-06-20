--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 森罗的仙树 凤凰木  (ID: 25824484)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Plant
-- Level 8
-- ATK 2700 | DEF 1800
-- Setcode: 144
--
-- Effect Text:
-- 1回合1次，自己的主要阶段时才能发动。自己卡组最上面的卡翻开。翻开的卡是植物族怪兽的场合，那只怪兽送去墓地，从卡组抽1张卡。不是的场合，那张卡回到卡组最下面。此外，卡组的这张卡被卡的效果翻开送去墓地的
-- 场合，从自己卡组上面把最多3张卡确认，用喜欢的顺序回到卡组上面。
--[[ __CARD_HEADER_END__ ]]

--森羅の仙樹 レギア
function c25824484.initial_effect(c)
	--deck check
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25824484,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c25824484.target)
	e1:SetOperation(c25824484.operation)
	c:RegisterEffect(e1)
	--sort decktop
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(25824484,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c25824484.sdcon)
	e2:SetOperation(c25824484.sdop)
	c:RegisterEffect(e2)
end
function c25824484.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c25824484.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsRace(RACE_PLANT) then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_REVEAL)
		Duel.Draw(tp,1,REASON_EFFECT)
	else
		Duel.MoveSequence(tc,SEQ_DECKBOTTOM)
	end
end
function c25824484.sdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_DECK) and c:IsReason(REASON_REVEAL)
end
function c25824484.sdop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct==0 then return end
	local ac=1
	if ct>1 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(25824484,2))
		if ct==2 then ac=Duel.AnnounceNumber(tp,1,2)
		else ac=Duel.AnnounceNumber(tp,1,2,3) end
	end
	Duel.SortDecktop(tp,tp,ac)
end
