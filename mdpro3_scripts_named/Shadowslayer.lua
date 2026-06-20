--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 暗之住人 暗影杀手  (ID: 20939559)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1400 | DEF 200
--
-- Effect Text:
-- 对方的怪兽卡区域只有守备表示怪兽的场合，这张卡可以直接攻击对方玩家。
--[[ __CARD_HEADER_END__ ]]

--闇の住人 シャドウキラー
function c20939559.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c20939559.con)
	c:RegisterEffect(e1)
end
function c20939559.con(e)
	return not Duel.IsExistingMatchingCard(Card.IsAttackPos,e:GetHandler():GetControler(),0,LOCATION_MZONE,1,nil)
end
