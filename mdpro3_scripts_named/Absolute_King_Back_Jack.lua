--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 绝对王 J革命  (ID: 60990740)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：对方回合把墓地的这张卡除外才能发动。自己卡组最上面的卡翻开，那张卡是通常陷阱卡的场合，在自己场上盖放。不是的场合，那张卡送去墓地。这个效果盖放的卡在盖放的回合也能发动。
-- ②：这张卡被送去墓地的场合才能发动。从自己卡组上面把3张卡确认，用喜欢的顺序回到卡组上面。
--[[ __CARD_HEADER_END__ ]]

--絶対王 バック・ジャック
function c60990740.initial_effect(c)
	--sset
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DECKDES+CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,60990740)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c60990740.condition)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c60990740.target)
	e1:SetOperation(c60990740.operation)
	c:RegisterEffect(e1)
	--sort
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,60990741)
	e2:SetTarget(c60990740.sdtg)
	e2:SetOperation(c60990740.sdop)
	c:RegisterEffect(e2)
end
function c60990740.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c60990740.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsPlayerCanSSet(tp) end
end
function c60990740.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	Duel.DisableShuffleCheck()
	if tc:GetType()==TYPE_TRAP and Duel.SSet(tp,tc)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(60990740,0))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
		e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	else
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_REVEAL)
	end
end
function c60990740.sdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>2 end
end
function c60990740.sdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,tp,3)
end
