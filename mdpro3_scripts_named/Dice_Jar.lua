--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 骰子壶  (ID: 3549275)
-- Type: Monster / Effect / Toon
-- Attribute: LIGHT
-- Race: Rock
-- Level 3
-- ATK 200 | DEF 300
--
-- Effect Text:
-- 反转：双方各自投掷1个骰子。投掷出来的数目比另一方低的玩家，受到（另一方投掷出的数目×500）的基本分的伤害。如果输给投掷出数目6的场合，输的玩家受到的是6000分的伤害。平局的场合再掷1次。
--[[ __CARD_HEADER_END__ ]]

--ダイス・ポット
function c3549275.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c3549275.target)
	e1:SetOperation(c3549275.operation)
	c:RegisterEffect(e1)
end
function c3549275.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,PLAYER_ALL,1)
end
function c3549275.operation(e,tp,eg,ep,ev,re,r,rp)
	local d1=0
	local d2=0
	while d1==d2 do
		d1,d2=Duel.TossDice(tp,1,1)
	end
	if d1<d2 then
		if d2==6 then
			Duel.Damage(tp,6000,REASON_EFFECT)
		elseif d2>=2 and d2<=5 then
			Duel.Damage(tp,d2*500,REASON_EFFECT)
		end
	else
		if d1==6 then
			Duel.Damage(1-tp,6000,REASON_EFFECT)
		elseif d1>=2 and d1<=5 then
			Duel.Damage(1-tp,d1*500,REASON_EFFECT)
		end
	end
end
