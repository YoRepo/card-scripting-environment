--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 玄翼龙 黑翼  (ID: 60992105)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 2800 | DEF 1600
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 1回合1次，战斗或者卡的效果让自己受到伤害时才能发动。从自己卡组上面把最多5张卡送去墓地。这个效果送去墓地的卡之中有怪兽卡的场合，这张卡的攻击力上升400。
--[[ __CARD_HEADER_END__ ]]

--玄翼竜 ブラック・フェザー
function c60992105.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60992105,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCountLimit(1)
	e1:SetCondition(c60992105.condition)
	e1:SetTarget(c60992105.target)
	e1:SetOperation(c60992105.operation)
	c:RegisterEffect(e1)
end
function c60992105.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c60992105.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c60992105.filter(c)
	return c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_MONSTER)
end
function c60992105.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct==0 then return end
	if ct>5 then ct=5 end
	local t={}
	for i=1,ct do t[i]=i end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(60992105,1))
	local ac=Duel.AnnounceNumber(tp,table.unpack(t))
	Duel.DiscardDeck(tp,ac,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	if g:IsExists(c60992105.filter,1,nil) and c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(400)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
