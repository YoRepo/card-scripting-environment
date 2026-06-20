--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 念动力防卫者  (ID: 29417188)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Psychic
-- Level 4
-- ATK 1200 | DEF 300
--
-- Effect Text:
-- ①：1回合1次，宣言1个卡名才能发动。直到对方回合结束时为止的期间，宣言的卡名为原本卡名的双方的卡受以下所适用。
-- ●不能在场上出现。
-- ●不能作卡的发动以及效果的发动和适用。
-- ●不能通常召唤·反转召唤·特殊召唤。
-- ●不能作攻击以及表示形式的变更。
-- ●不能作为要为需要素材的特殊召唤而用的素材。
--[[ __CARD_HEADER_END__ ]]

--サイキック・ブロッカー
function c29417188.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29417188,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c29417188.target)
	e1:SetOperation(c29417188.operation)
	c:RegisterEffect(e1)
end
function c29417188.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
	local ac=Duel.AnnounceCard(tp)
	Duel.SetTargetParam(ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,0)
end
function c29417188.operation(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	e:GetHandler():SetHint(CHINT_CARD,ac)
	--forbidden
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_FORBIDDEN)
	e1:SetTargetRange(0xff,0xff)
	e1:SetTarget(c29417188.bantg)
	e1:SetLabel(ac)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
end
function c29417188.bantg(e,c)
	local fcode=e:GetLabel()
	return c:IsOriginalCodeRule(fcode)
end
