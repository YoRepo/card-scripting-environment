--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 黑羽-地雷  (ID: 43906884)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 51
--
-- Effect Text:
-- 盖放的这张卡被对方的效果破坏时，自己场上有名字带有「黑羽」的怪兽表侧表示存在的场合，给与对方基本分1000分伤害，自己从卡组抽1张卡。
--[[ __CARD_HEADER_END__ ]]

--BF－マイン
function c43906884.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(43906884,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c43906884.con)
	e1:SetTarget(c43906884.tg)
	e1:SetOperation(c43906884.op)
	c:RegisterEffect(e1)
end
function c43906884.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x33)
end
function c43906884.con(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,0x41)==0x41 and rp==1-tp
		and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
		and e:GetHandler():IsPreviousPosition(POS_FACEDOWN)
		and Duel.IsExistingMatchingCard(c43906884.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c43906884.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c43906884.op(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c43906884.filter,tp,LOCATION_MZONE,0,1,nil) then return end
	Duel.Damage(1-tp,1000,REASON_EFFECT)
	Duel.Draw(tp,1,REASON_EFFECT)
end
