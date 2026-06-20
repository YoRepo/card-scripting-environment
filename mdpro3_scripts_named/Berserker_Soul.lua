--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 狂战士之魂  (ID: 15381252)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「狂战士之魂」在1回合只能发动1张。
-- ①：自己场上的怪兽直接攻击给与对方1500以下的伤害时，把手卡全部丢弃才能发动。自己卡组最上面的卡翻开，那是怪兽的场合，那只怪兽送去墓地，给与对方500伤害。那之后，直到怪兽以外被翻开为止让这个效果重
-- 复（最多7次）。翻开的卡是怪兽以外的场合，那张卡回到卡组最上面。
--[[ __CARD_HEADER_END__ ]]

--狂戦士の魂
function c15381252.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCountLimit(1,15381252+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c15381252.condition)
	e1:SetCost(c15381252.cost)
	e1:SetTarget(c15381252.target)
	e1:SetOperation(c15381252.activate)
	c:RegisterEffect(e1)
end
function c15381252.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and eg:GetFirst():GetControler()==tp and ev<=1500 and Duel.GetAttackTarget()==nil
end
function c15381252.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		g:RemoveCard(e:GetHandler())
		return g:GetCount()>0 and g:FilterCount(Card.IsDiscardable,nil)==g:GetCount()
	end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
end
function c15381252.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c15381252.activate(e,tp,eg,ep,ev,re,r,rp)
	local count=8
	while count>0 and Duel.IsPlayerCanDiscardDeck(tp,1) and Duel.GetLP(1-tp)>0 do
		if count<8 then Duel.BreakEffect() end
		Duel.ConfirmDecktop(tp,1)
		local g=Duel.GetDecktopGroup(tp,1)
		local tc=g:GetFirst()
		if tc:IsType(TYPE_MONSTER) then
			Duel.DisableShuffleCheck()
			Duel.SendtoGrave(tc,REASON_EFFECT+REASON_REVEAL)
			if tc:IsLocation(LOCATION_GRAVE) then
				Duel.Damage(1-tp,500,REASON_EFFECT)
				count=count-1
			else count=0 end
		else
			count=0
		end
	end
end
