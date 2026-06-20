--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 乘龙的翼龙战士  (ID: 3366982)
-- Type: Monster / Effect / Fusion
-- Attribute: WIND
-- Race: Dragon
-- Level 5
-- ATK 1700 | DEF 1500
--
-- Effect Text:
-- 「宝贝龙」＋「翼龙战士」
-- ①：对方场上的表侧表示怪兽只有地·水·炎属性怪兽的场合，这张卡可以直接攻击。
--[[ __CARD_HEADER_END__ ]]

--ドラゴンに乗るワイバーン
function c3366982.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,88819587,64428736,true,true)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c3366982.dircon)
	c:RegisterEffect(e2)
end
function c3366982.filter(c)
	return c:IsFaceup() and c:IsAttribute(0xf8)
end
function c3366982.dircon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
		and not Duel.IsExistingMatchingCard(c3366982.filter,tp,0,LOCATION_MZONE,1,nil)
end
