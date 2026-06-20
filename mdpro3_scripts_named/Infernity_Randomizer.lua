--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 永火上膛者  (ID: 13582837)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 1
-- ATK 900 | DEF 0
-- Setcode: 11
--
-- Effect Text:
-- 自己手卡是0张的场合，1回合1次，可以从自己卡组抽1张卡。这个效果抽到的卡给双方确认，怪兽卡的场合，给与对方基本分那只怪兽的等级×200的数值的伤害。魔法·陷阱卡的场合，自己受到500分伤害。
--[[ __CARD_HEADER_END__ ]]

--インフェルニティ・リローダー
function c13582837.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13582837,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c13582837.spcon)
	e1:SetTarget(c13582837.sptg)
	e1:SetOperation(c13582837.spop)
	c:RegisterEffect(e1)
end
function c13582837.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
end
function c13582837.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,1,tp,1)
end
function c13582837.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)~=0 then return end
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	Duel.Draw(tp,1,REASON_EFFECT)
	if tc then
		Duel.ConfirmCards(1-tp,tc)
		Duel.BreakEffect()
		if tc:IsType(TYPE_MONSTER) then
			Duel.Damage(1-tp,tc:GetLevel()*200,REASON_EFFECT)
		else
			Duel.Damage(tp,500,REASON_EFFECT)
		end
		Duel.ShuffleHand(tp)
	end
end
