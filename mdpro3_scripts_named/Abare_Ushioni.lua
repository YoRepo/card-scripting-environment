--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 暴走牛鬼  (ID: 89718302)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level 4
-- ATK 1200 | DEF 1200
--
-- Effect Text:
-- 猜硬币正反。
-- ●猜中的场合：给与对方基本分1000分的伤害。
-- ●猜错的场合：自己基本分受到1000分的伤害。这个效果1回合只能1次，在自己回合的主要阶段使用。
--[[ __CARD_HEADER_END__ ]]

--暴れ牛鬼
function c89718302.initial_effect(c)
	--coin
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89718302,0))
	e1:SetCategory(CATEGORY_COIN+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c89718302.damtg)
	e1:SetOperation(c89718302.damop)
	c:RegisterEffect(e1)
end
function c89718302.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c89718302.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COIN)
	local coin=Duel.AnnounceCoin(tp)
	local res=Duel.TossCoin(tp,1)
	if coin~=res then
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	else
		Duel.Damage(tp,1000,REASON_EFFECT)
	end
end
